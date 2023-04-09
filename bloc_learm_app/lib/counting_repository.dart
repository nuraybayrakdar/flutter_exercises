class CountingRepository {
  int topla(String input1, String input2) {
    int sayi1 = int.parse(input1);
    int sayi2 = int.parse(input2);
    int sum = sayi1 + sayi2;
    return sum;
  }

  int carp(String input1, String input2) {
    int sayi1 = int.parse(input1);
    int sayi2 = int.parse(input2);
    int carpim = sayi1 * sayi2;
    return carpim;
  }
}
