/*
 * compile: g++ -o statechart_test boost_statechart.cc --std=gnu++11
 */
#include <iostream>
#include <boost/statechart/state_machine.hpp>
#include <boost/statechart/state.hpp>
#include <boost/statechart/simple_state.hpp>
#include <boost/mpl/list.hpp>
#include <boost/statechart/transition.hpp>

namespace sc = boost::statechart;
namespace mpl = boost::mpl;

/* template example */
template< typename X > struct A;
struct Machine : sc::state_machine< Machine, A< int > > {};

template< typename X > struct B;
template< typename X >
struct A : sc::simple_state< A< X >, Machine, mpl::list< B< X > > > {};

template< typename X >
struct B : sc::simple_state< B< X >, A< X > > {};

/* basic example */
struct Initial;
struct Stage_1 : sc::state_machine< Stage_1, Initial > {};

struct HowAreYou;
struct ToLeave;
struct WaitResponse;
struct SayHello;

struct SayGoodBye;
struct SayGoodBye : sc::event< SayGoodBye > {
        SayGoodBye() : sc::event< SayGoodBye >() {
                std::cout << "Bye World!" << std::endl;
        }
};

struct SayHello : sc::event< SayHello > {
        SayHello() : sc::event< SayHello >() {
                std::cout << "Hello World!" << std::endl;
        }
};

struct Initial : sc::state< Initial, Stage_1 , HowAreYou>
{
	Initial(my_context ctx)
	  : my_base(ctx) {
		std::cout << "Stage_1 init!" << std::endl;
	}
	void exit();
	~Initial(void) {
		std::cout << "Stage_1 uninit!" << std::endl;
	}

	/*
	 * If you have multiple transitions, using mpl::list
	 *
	 * typedef mpl::list <
	 * 	sc::transition< event1, stateWant >,
	 * 	sc::transition< event2, stateWant >
	 * > reactions;
	 *
	 */
};

void Initial::exit() {};

  struct HowAreYou : sc::state< HowAreYou, Initial, WaitResponse>
  {
  	HowAreYou(my_context ctx) : my_base(ctx) {
		std::cout << "How Are You?" << std::endl;
	}
	void exit();
  };

  struct WaitResponse : sc::state< WaitResponse, HowAreYou >
  {
	  WaitResponse(my_context ctx): my_base(ctx) {
		  std::cout << "Waiting response..." << std::endl;
		  post_event( SayHello() );
	  }
	  typedef sc::transition< SayHello, ToLeave > reactions;
  };

  void HowAreYou::exit() {
	  std::cout << "exit HowAreYou!" << std::endl;
  }

  struct ToLeave : sc::state< ToLeave, HowAreYou >
  {
  	ToLeave(my_context ctx) : my_base(ctx) {
		std::cout << "Prepare to Leave..." << std::endl;
		post_event( SayGoodBye() );
	}	
  };

int main()
{
	Machine machine;
	machine.initiate();
	Stage_1 stage1;
	stage1.initiate();
	return 0;
}
