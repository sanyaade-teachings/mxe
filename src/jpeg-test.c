/* This file is part of mingw-cross-env.       */
/* See doc/index.html for further information. */

#include <stdio.h>
#include <windows.h>
#include <jpeglib.h>

int main(int argc, char* argv[])
{
    boolean test_boolean;
    INT32 test_int32;
    struct jpeg_decompress_struct cinfo;

    (void)argc;
    (void)argv;

    test_boolean = TRUE;
    test_int32 = 1;
    jpeg_create_decompress(&cinfo);
    jpeg_destroy_decompress(&cinfo);

    return 0;
}