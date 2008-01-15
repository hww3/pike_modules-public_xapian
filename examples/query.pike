import Public.Xapian;


int main(int argc, array argv)
{
  object database = Database(argv[1]);
  object e = Enquire(database);
  object s = Stem("english");
  object q = QueryParser();
  q->set_stemmer(s);
  object query;
  array terms = argv[2..];
  query = q->parse_query(terms*" ", 0);

  e->set_query(query, 0);
  object mset = e->get_mset(0, 100, 10);

  write("got %d hits.\n", mset->size());

  object i;
  i = mset->begin();
  while( i != mset->end())
  {
    werror(i->get_percent() + "%: " + i->get_document()->get_value(1)  + "\n");
    i->next();
  }

  return 0;
}
