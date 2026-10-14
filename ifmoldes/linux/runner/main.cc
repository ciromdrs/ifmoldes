#include "my_application.h"

int main(int argc, char** argv) {
  g_autoptr(GError) error = nullptr;
  g_autofree gchar* executable_path = g_file_read_link("/proc/self/exe", &error);
  if (executable_path == nullptr) {
    g_printerr("Failed to locate the application executable: %s\n",
               error->message);
    return 1;
  }

  g_autofree gchar* executable_dir = g_path_get_dirname(executable_path);
  g_autofree gchar* schema_dir =
      g_build_filename(executable_dir, "data", "glib-2.0", "schemas", nullptr);
  g_autofree gchar* compiled_schema =
      g_build_filename(schema_dir, "gschemas.compiled", nullptr);
  if (!g_file_test(compiled_schema, G_FILE_TEST_IS_REGULAR)) {
    g_printerr("Bundled GSettings compatibility schema not found: %s\n",
               compiled_schema);
    return 1;
  }
  if (!g_setenv("GSETTINGS_SCHEMA_DIR", schema_dir, TRUE)) {
    g_printerr("Failed to set the bundled GSettings schema directory\n");
    return 1;
  }

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
