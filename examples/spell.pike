import Public.Xapian;


int main(int argc, array argv)
{
  object database = Database(argv[1]);

  werror("spelling correction for %s: %s\n", argv[2], 
database->get_spelling_suggestion(argv[2], 2));

  foreach(database->synonyms_iterator(argv[2]);;object t)
    werror(" %s\n", t->get_term());

  return 0;
}
