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
    int i;
    bool b;

    o = fast_clone_object(Xapian_Document_program);
    d = (doc);
    OBJ2_DOCUMENT(o)->object_data->document = &d;

    push_object(o);

    apply_svalue(fx, 1);
    i = Pike_sp[-1].u.integer;
    pop_stack();
    if(i == 0) b = false;
    else b = true;

    return b;
  }
};
