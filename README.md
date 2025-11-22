# XOR Crypt Tool

This project is a simple command‑line tool that can encrypt/decrypt a
file using an 8-bit XOR key. It can also run a full brute‑force pass
over all 256 possible keys.

### Features

-   Encryption/decryption using 8-bit XOR
-   Bruteforce mode (tries all keys from 0--255)
-   Works on `danger/test.txt`
-   Written in Zig

### Usage

    Choose mode (e/d [1] , brute [2]) :

#### Mode 1 -- Encrypt/Decrypt (1)

Asks the user for an 8-bit key and XORs the file contents.

#### Mode 2 -- Bruteforce (2)

Tries every key value (0--255) and prints the output for each attempt.

---