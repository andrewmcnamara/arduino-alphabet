# copyright 2018 by Charl P. Botha <cpbotha@vxlabs.com>

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)

# on Linux, this should be: $ENV{HOME}/.arduino15/packages
SET(ARDUINO_PACKAGES $ENV{HOME}/.arduino15/packages)
# on Linux, this will be WHERE_YOU_UNPACKED/arduino
SET(ARDUINO_CMD /opt/arduino/arduino)

# specify the cross compiler
set(CMAKE_C_COMPILER ${ARDUINO_PACKAGES}/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc)
set(CMAKE_CXX_COMPILER ${ARDUINO_PACKAGES}/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++)

# use arduino --verify --verbose command, then wait for FINAL cpp compilation to extract these arguments, the include
# directories below this, and the definitions below that.
# hint: look in the output for "Compiling sketch..."
SET(COMMON_FLAGS "-c -g -Os -w -ffunction-sections -fdata-sections -MMD -flto -mmcu=atmega328p")
SET(CMAKE_CXX_FLAGS "${COMMON_FLAGS} -std=gnu++11 -fpermissive -fno-exceptions -fno-threadsafe-statics -fno-rtti -fno-exceptions")
SET(CMAKE_C_FLAGS "${COMMON_FLAGS} -std=gnu11 -fno-fat-lto-objects")
# https://stackoverflow.com/questions/19419782/exit-c-text0x18-undefined-reference-to-exit-when-using-arm-none-eabi-gcc
# https://github.com/vpetrigo/arm-cmake-toolchains/blob/master/arm-gcc-toolchain.cmake
#SET(CMAKE_EXE_LINKER_FLAGS_INIT "-specs=nosys.specs")
#SET(CMAKE_EXE_LINKER_FLAGS "-specs=nosys.specs")


# BLOODY HELL it's all because it's an ino file and not a cpp ARGH ARGH ARGH don't be so primitve!
# http://docs.platformio.org/en/latest/faq.html#convert-arduino-file-to-c-manually
# (clion ignores all of these if include directories you try to keep your code in the .ino file,
#  that's why we move it out to cpp!)
include_directories(
        ${ARDUINO_PACKAGES}/arduino/hardware/avr/1.6.21/cores/arduino
        ${ARDUINO_PACKAGES}/arduino/hardware/avr/1.6.21/variants/standard
)
#-c -g -x assembler-with-cpp -flto -MMD -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10805 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR   "-I/home/andrew/.arduino15/packages/arduino/hardware/avr/1.6.21/cores/arduino" "-I/home/andrew/.arduino15/packages/arduino/hardware/avr/1.6.21/variants/standard" "/home/andrew/.arduino15/packages/arduino/hardware/avr/1.6.21/cores/arduino/wiring_pulse.S" -o "/tmp/arduino_build_657864/core/wiring_pulse.S.o"


#"/home/andrew/.arduino15/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc" -c -g -Os -w -std=gnu11 -ffunction-sections -fdata-sections -MMD -flto -fno-fat-lto-objects -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10805 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR   "-I/home/andrew/.arduino15/packages/arduino/hardware/avr/1.6.21/cores/arduino" "-I/home/andrew/.arduino15/packages/arduino/hardware/avr/1.6.21/variants/standard" "/home/andrew/.arduino15/packages/arduino/hardware/avr/1.6.21/cores/arduino/WInterrupts.c" -o "/tmp/arduino_build_657863/core/WInterrupts.c.o"


add_definitions(
        -DF_CPU=16000000L
        -DARDUINO=10805
        -DARDUINO_AVR_UNO
        -DARDUINO_ARCH_AVR
)
#"/home/andrew/.arduino15/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-gcc"
#-w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=atmega328p  -o "/tmp/arduino_build_657863/Blink.ino.elf"
#"/tmp/arduino_build_657863/sketch/Blink.ino.cpp.o" "/tmp/arduino_build_657863/core/core.a" "-L/tmp/arduino_build_657863" -lm


#"/home/andrew/.arduino15/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-objcopy" -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0  "/tmp/arduino_build_657863/Blink.ino.elf" "/tmp/arduino_build_657863/Blink.ino.eep"
#"/home/andrew/.arduino15/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-objcopy" -O ihex -R .eeprom  "/tmp/arduino_build_657863/Blink.ino.elf" "/tmp/arduino_build_657863/Blink.ino.hex"


