#include "ruby.h"

static VALUE
stderr_initialize(int argc, VALUE *argv, VALUE exc)
{
    rb_call_super(argc, argv);
    rb_iv_set(exc, "@binding", rb_binding_new());
    return exc;
}

void
Init_debug_exception(void)
{
    rb_define_method(rb_eStandardError, "initialize", stderr_initialize, -1);
}
