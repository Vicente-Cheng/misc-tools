#include <iostream>
#include <string>

using t1 = uint64_t;
using t2 = int64_t;

template<typename T>
std::string foo(T)
{
    if (std::is_same<T, t1>::value)
        return "t1";
    else
        return "t2";
}

int main()
{
    t1 var_t1;
    t2 var_t2;
    std::cout << foo(var_t1) << std::endl;
    std::cout << foo(var_t2) << std::endl;

    return 0;
}
