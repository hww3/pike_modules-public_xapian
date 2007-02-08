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

  for(i = mset->begin(); i != mset->end(); i->next())
  {
    werror(i->get_percent() + "%: " + i->get_document()->get_data()  + "\n");
  }

  return 0;
}
