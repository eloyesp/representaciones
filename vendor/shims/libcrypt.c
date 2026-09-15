#include <dlfcn.h>
#include <stddef.h>

static char *(*real_crypt)(const char *, const char *);

char *crypt(const char *key, const char *salt) {
  if (!real_crypt) {
    void *h = dlopen("libcrypt.so.2", RTLD_LAZY | RTLD_GLOBAL);
    if (!h) return NULL;
    real_crypt = (char *(*)(const char *, const char *))dlsym(h, "crypt");
  }
  if (!real_crypt) return NULL;
  return real_crypt(key, salt);
}
