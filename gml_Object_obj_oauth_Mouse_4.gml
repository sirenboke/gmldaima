if (clipboard_has_text())
{
    message = clipboard_get_text();
    clipboard_set_text("");
}
