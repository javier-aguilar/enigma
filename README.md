## Engima

This project uses Ruby to build a tool for cracking an encryption algorithm based on the Caesar Cipher

## Usage

To encrypt -source -destination:

`$ ruby ./lib/encrypt.rb message.txt encrypted.txt`

To decrypt -encrypted_source -destination -key -date:

`$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 030220`

To crack -encrypted_source -destination -date:

`ruby ./lib/crack.rb encrypted.txt cracked.txt 030220`

***
## Self Assessment

#### Functionality: 4

I have implemented an encrypt and decrypt method that work via CLI. I have also implemented a cracking method that works via CLI

#### Object Oriented Programming: 4

I have included more than one module to help structure and organize my code

#### Ruby Conventions and Mechanics: 3.5

Code is properly indented and no method is longer than 10 lines. Variables and methods could have better naming conventions

#### Test Driven Development: 4

Coverage is 100% and stubs are used to test random/every changing factors such as current date

#### Version Control: 3.5

More than 40 commits and 5 pull requests. Each commit describes what has happened in reference to the code
