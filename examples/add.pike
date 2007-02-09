import Public.Xapian;


int main(int argc, array argv)
{
  object database = WriteableDatabase(argv[1], DB_CREATE_OR_OPEN);

  string doc = Stdio.read_file(argv[2]);
  doc = replace(doc, ({"\t", "\r", "\n"}), ({" ", " ", " "}));

  array terms = (doc / " ") - ({""});

  object s = Stem("english");
  object d = Document();

  d->add_value(0, argv[2]);

  foreach(terms; int i; string term)
  {
    werror("term: " + term + "\n");
    d->add_posting(s->stem_word(lower_case(term)), i, 1);
  }

  d->set_data(argv[2]);

  database->add_document(d);
  database = 0;
  return 0;
}
