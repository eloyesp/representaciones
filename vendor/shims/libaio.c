/* Minimal libaio.so.1 shim so the MySQL 8 binaries bundled via mise can link.
 *
 * This host does not ship libaio (and we have no global perms to install it).
 * InnoDB is configured with innodb_use_native_aio=0, so these calls only ever
 * need to fail cleanly rather than actually submit I/O.
 */
#include <stdlib.h>

struct io_event {
  unsigned long long data, obj, res, res2;
};

int io_setup(unsigned maxevents, void **ctxp) {
  return -38; /* -ENOSYS */
}

long io_submit(void *ctx, long nr, void **iocbs) {
  return -38;
}

int io_getevents(void *ctx, long min_nr, long nr,
                 struct io_event *events, void *timeout) {
  return -38;
}

int io_destroy(void *ctx) {
  return 0;
}