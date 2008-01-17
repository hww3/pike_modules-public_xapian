import Public.Xapian;


int main(int argc, array argv)
{
  object database = Database(argv[1]);
  object e = Enquire(database);
  object s = Stem("english");
  object q = QueryParser();
  q->set_stemmer(s);
  q->set_stemming_strategy(Public.Xapian.QueryParser.STEM_SOME);
  object query;
  array terms = argv[2..];
  query = q->parse_query(terms*" ", 0);
werror("Query: %O\n", query);
  e->set_query(query, 0);
  object mset = e->get_mset(0, 100, 10);

  write("got %d hits.\n", mset->size());
//  object i;
//  i = mset->begin();
//  while( i != mset->end())
  foreach(mset; int ix; object i)
  {
    werror(i->get_percent() + "%: " + i->get_document()->get_value(1)  + "\n");
    foreach(i->get_document()->value_iterator(); int id; object v)
    {
      werror("  value %d: %s\n", id, v->get_value());
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
