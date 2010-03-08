class PikeExpandDeciderProxy: public Xapian::ExpandDecider
{
  struct svalue * fx;

  public:
  PikeExpandDeciderProxy(struct svalue * func)
  {
    fx = func;
  }

  virtual bool operator()(const std::string & term) const 
  {
    int i;
    bool b;

    push_text(term.c_str());

    apply_svalue(fx, 1);
    i = Pike_sp[-1].u.integer;
    pop_stack();
    if(i == 0) b = false;
    else b = true;

    return b;
  }
};
