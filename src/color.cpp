// return colored string
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <map>
#include <string>
using namespace std;

int main(int argc, char *argv[]) {
  if (argc == 1) {
    cout << "[USAGE]" << endl;
    cout << "   $" << argv[0]
         << " [black|red|green|yellow|blue|magenta|cyan|white] STRING" << endl;
    exit(0);
  }

  map<string, int> colors;
  colors["black"] = 30;
  colors["red"] = 31;
  colors["green"] = 32;
  colors["yellow"] = 33;
  colors["blue"] = 34;
  colors["magenta"] = 35;
  colors["cyan"] = 36;
  colors["white"] = 37;
  colors["reset"] = 0;

  string str;
  int i;
  for (i = 2; i < argc; i++) {
    str += argv[i];
  }
  cout << "\033[" << colors[argv[1]] << "m" << str << "\033[m" << endl;
  return 0;
}
