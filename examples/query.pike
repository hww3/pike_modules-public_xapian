import Public.Xapian;
//import module;

int main(int argc, array argv)
{
  if(argc != 3)
  {
    werror("usage: query.pike xapianDb ftQuery\n");
    exit(1);
  }

  object database = Database(argv[1]);
  object e = Enquire(database);
  object s = Stem("english");
  object q = QueryParser();

  q->set_stemmer(s);
  q->set_stemming_strategy(Public.Xapian.QueryParser.STEM_SOME);
  q->set_database(database);
  object query;
  array terms = argv[2..];
  query = q->parse_query(terms*" ", QueryParser.FLAG_SPELLING_CORRECTION);

werror("Query: %O\n", query);
string cqs = q->get_corrected_query_string();
if(sizeof(cqs))
  werror("did you mean: %O?\n", cqs);

  e->set_query(query, 0);
  object mset = e->get_mset(0, 100, 10);

  write("got %d hits.\n", mset->size());
//  object i;
//  i = mset->begin();
//  while( i != mset->end())
  foreach(mset; int ix; object i)
  {
    object d = i->get_document();
    werror(i->get_percent() + "%: " + d->get_value(1)  + " (id=" + i->get_docid() + ")\n");
    foreach(d->value_iterator(); int id; object v)
    {
      werror("  value %d: %s\n", id, v);
    }

      werror("  matching terms:");
    foreach(e->get_matching_terms(i->get_docid()); ; mixed term)
    {
      werror(" %s", term->get_term());
    }
    werror("\n");
/*
    foreach(i->get_document()->term_iterator(); int id; object v)
    {
      werror(" term %d: %s, at ", id, v->get_term());
        foreach(v->position_iterator(); int ip; object p)
          werror(p->get_position() + " ");
      werror("\n");
    }
*/
  }

  return 0;
}
