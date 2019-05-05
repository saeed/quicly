/*
 * Copyright (c) 2019 Fastly, Kazuho Oku
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 *
 * Below is an example bpftrace script that logs the events in JSON-logging
 * format.  The script can be invoked like:
 *
 * % sudo dtrace -c './cli 127.0.0.1 4433' -s misc/dtrace/dtrace.d
 */

#define GET_CONN_ID(conn) (*(uint32_t *)copyin(conn + 16, 4))
#define GET_STREAM_ID(stream) (*(uint64_t *)copyin(stream + 8, 8))

quicly$target:::quicly_connect {
    printf("\n{\"conn\": %d, \"scid\": \"%s\", \"dcid\": \"%s\"}", GET_CONN_ID(arg0), copyinstr(arg1), copyinstr(arg2));
}