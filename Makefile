# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# $Id$

CFLAGS = -Wall -O2 -s

.SUFFIXES: .bin

all: sgabios.bin

sgabios.bin: sgabios.S version.h

version.h: Makefile sgabios.S
	@echo '#define BIOS_BUILD_DATE "'`date -u +%D`'"' >version.h
	@echo '#define BIOS_FULL_DATE "'`date -u`'"' >>version.h
	@echo '#define BIOS_BUILD_HOST "'`echo $$LOGNAME@$$HOSTNAME`'"' >>version.h

.S.bin:
	$(CC) -c $(CFLAGS) $*.S -o $*.o
	$(LD) -Ttext 0x0 -s --oformat binary $*.o -o $*.bin

clean:
	$(RM) *.s *.o *.bin *.srec *.com version.h
