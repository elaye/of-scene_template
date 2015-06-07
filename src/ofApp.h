#pragma once

#include "ofMain.h"

#include "Scene.h"

class ofApp : public ofBaseApp{

	ofEasyCam cam;
	Scene scene;

	ofLight light;
	ofMaterial material;

	int lightLat, lightLon, lightDist;

	public:
		void setup();
		void setupLight();
		void setupMaterial();
		void update();
		void draw();
		void drawLight();
		void drawGrid();
		void keyPressed(int key);
};
