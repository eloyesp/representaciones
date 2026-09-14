/* Minimal libnuma.so.1 shim so the MySQL 8 binaries bundled via mise can link.
 *
 * This host has no NUMA support (single node), so we report "unavailable",
 * which is a valid, handled state for MySQL server.
 */
#include <stdlib.h>

int numa_available(void) {
  return -1;
}

void *numa_alloc_local(size_t size) {
  return malloc(size);
}

int numa_free(void *start, size_t size) {
  free(start);
  return 0;
}

void numa_bitmask_free(void *bitmask) {
  free(bitmask);
}

void *numa_get_mems_allowed(void) {
  return NULL;
}