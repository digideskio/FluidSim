// FastPoissonDiskSampling.hpp

#pragma once

#include "GlfwOpenGlWindow.hpp"
#include "Renderer.hpp"

#include "FluidSim/NumericTypes.hpp"
#include "FluidSim/Grid.hpp"
#include "Timer.hpp"

#include <vector>


const int kScreenWidth = 768;
const int kScreenHeight = 768;


class FastPoissonDiskSampling : public GlfwOpenGlWindow {

public:
	FastPoissonDiskSampling();

	~FastPoissonDiskSampling();

	static std::shared_ptr<GlfwOpenGlWindow> getInstance();

private:
	std::vector<vec2> samples;

	Timer timer;
	Renderer * renderer;

	virtual void init();
	virtual void logic();
	virtual void draw();
	virtual void keyInput(int key, int action, int mods);
	virtual void cleanup();
};
