// the return value about emplace as below:
// pair<iterator, bool(emplace result)>
#include <iostream>
#include <utility>
#include <string>
#include <map>

void main()
{
    std::map<std::string, std::string> m;

    {
        std::cout << std::endl;
        std::cout << "prepare to emplace pair<a, a>"  << std::endl;
        auto ret = m.emplace(std::make_pair(std::string("a"), std::string("a")));
        std::cout << "emplace " << (ret.second ? "success!" : "fail!") << std::endl;
        auto iter = ret.first;
        std::cout << "got iterator then value as below: " << std::endl;
        std::cout << iter->first << " => " << iter->second << std::endl;
    }

    {
        std::cout << std::endl;
        std::cout << "prepare to emplace pair<b, abcd>"  << std::endl;
        auto ret = m.emplace(std::make_pair("b", "abcd"));
        std::cout << "emplace " << (ret.second ? "success!" : "fail!") << std::endl;
        auto iter = ret.first;
        std::cout << "got iterator then value as below: " << std::endl;
        std::cout << iter->first << " => " << iter->second << std::endl;
    }

    {
        std::cout << std::endl;
        std::cout << "prepare to emplace pair<a, ddd>"  << std::endl;
        auto ret = m.emplace("a", "ddd");
        std::cout << "emplace " << (ret.second ? "success!" : "fail!") << std::endl;
        auto iter = ret.first;
        std::cout << "got iterator then value as below: " << std::endl;
        std::cout << iter->first << " => " << iter->second << std::endl;
    }


    std::cout << "\nfinal result: " << std::endl;
    for (const auto &p : m) {
        std::cout << p.first << " => " << p.second << '\n';
    }

    return;
}
