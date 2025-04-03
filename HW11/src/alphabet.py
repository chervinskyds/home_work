class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = letters

    def print(self):
        print("".join(self.letters))

    def letters_num(self):
        return len(self.letters)


class EngAlphabet(Alphabet):
    __letters_num = 26  # приватний статичний атрибут

    def __init__(self):
        import string
        super().__init__('En', list(string.ascii_uppercase))  # A-Z

    def is_en_letter(self, letter):
        return letter.upper() in self.letters

    def letters_num(self):
        return self.__letters_num

    @staticmethod
    def example():
        return "The quick brown fox jumps over the lazy dog."


# Тести (main)
if __name__ == "__main__":
    eng_alphabet = EngAlphabet()

    # Виводимо всі літери
    eng_alphabet.print()

    # Кількість літер
    print("Number of letters:", eng_alphabet.letters_num())

    # Чи входить 'F' до англ. алфавіту
    print("'F' is in English alphabet:", eng_alphabet.is_en_letter('F'))

    # Чи входить 'Щ' до англ. алфавіту
    print("'Щ' is in English alphabet:", eng_alphabet.is_en_letter('Щ'))

    # Приклад тексту англійською
    print("Example:", EngAlphabet.example())
