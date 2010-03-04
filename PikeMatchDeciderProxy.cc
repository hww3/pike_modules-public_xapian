class PikeMatchDeciderProxy: public Xapian::MatchDecider
{
  struct svalue * fx;

  public:
  PikeMatchDeciderProxy(struct svalue * func)
  {
    fx = func;
  }

  virtual bool operator()(const Xapian::Document& doc) const 
  {
    struct object * o;
    Xapian::Document d;
    o = fast_clone_object(Document_program);
    d = (doc);
    OBJ2_DOCUMENT(o)->object_data->document = &d;

    push_object(o);

    apply_svalue(fx, 1);

    return true;
  }
};
