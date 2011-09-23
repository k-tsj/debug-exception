#include "ruby.h"

#define ID_UNDER_SAVE_BINDING rb_intern("__under_save_binding__")

static VALUE
save_binding(VALUE exc)
{
    rb_thread_local_aset(rb_thread_current(), ID_UNDER_SAVE_BINDING, Qtrue);
    rb_iv_set(exc, "@binding", rb_binding_new());
    return Qnil;
}

static VALUE
save_binding_ensure(void)
{
    rb_thread_local_aset(rb_thread_current(), ID_UNDER_SAVE_BINDING, Qfalse);
    return Qnil;
}

static VALUE
stderr_initialize(int argc, VALUE *argv, VALUE exc)
{
    rb_call_super(argc, argv);
    if (! RTEST(rb_thread_local_aref(rb_thread_current(), ID_UNDER_SAVE_BINDING))) {
        rb_ensure(save_binding, exc, save_binding_ensure, 0);
    }
    return exc;
}

void
Init_debug_exception(void)
{
    rb_define_method(rb_eStandardError, "initialize", stderr_initialize, -1);
}
