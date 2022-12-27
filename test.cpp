#include <iostream>
#include <string>
#include <vector>
using namespace std;

class Automata
{
    private:
        int count;
        string name;
        int array[5][2];
        int **twoDArray;
    protected:
        int childCount;
    public:
        void takeInput(int value, int size)
        {
            count = value;
            array[0][0] = size;
            name = "This is string";
        }

};

int main()
{
    char *ptr;
    int userArray[5];
    bool check;
    return 0;
}