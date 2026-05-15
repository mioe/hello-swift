// by mioe

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// MARK: - Hash helpers

static inline float hash11(float x) {
	return fract(sin(x * 12.9898) * 43758.5453);
}

static inline float hash21(float2 p) {
	return fract(sin(dot(p, float2(127.1, 311.7))) * 43758.5453);
}

// MARK: - Ring Scene

// Тёмный фон + неоновое фиолетовое кольцо с неровным контуром +
// сетка точек, каждая мерцает с собственной фазой и частотой.
// `center` — координаты центра view в пикселях.
[[ stitchable ]] half4 ringScene(float2 position, half4 color, float time, float2 center) {
	// Тёмно-синий фон
	half3 col = half3(0.015h, 0.010h, 0.055h);

	// --- Кольца, расходящиеся от центра наружу ---
	float2 d = position - center;
	float dist = length(d);
	float angle = atan2(d.y, d.x);

	// До дальнего угла экрана
	float maxR = length(center) * 1.15;
	float period = 5.0; // секунд на полный "пробег" кольца наружу

	const int RING_COUNT = 4;
	float ringThickness = 32.0;

	half3 purple = half3(0.55h, 0.22h, 0.95h);
	half3 hotPurple = half3(0.85h, 0.55h, 1.0h);
	half3 acc = half3(0.0h);

	for (int i = 0; i < RING_COUNT; i++) {
		float fi = float(i);
		float phaseOff = fi / float(RING_COUNT);
		float progress = fract(time / period + phaseOff);

		// Неровность радиуса: сумма синусов + сдвиг по фазе, чтобы кольца отличались
		float ang = angle + phaseOff * 6.2831;
		float wobble =
			sin(ang * 3.0 + time * 0.6 + fi) * 22.0 +
			sin(ang * 5.0 - time * 0.4 + fi * 1.7) * 14.0 +
			sin(ang * 7.0 + time * 0.9 + fi * 2.3) * 8.0;

		float r = progress * maxR + wobble;
		float ringDist = abs(dist - r);

		float core = exp(-(ringDist * ringDist) / (ringThickness * ringThickness));
		float halo = exp(-(ringDist * ringDist) / (ringThickness * ringThickness * 9.0));

		// Плавно появляется и затухает: 0 → 1 → 0 за цикл
		float fade = sin(progress * 3.14159);

		// Угловая неравномерность яркости
		float angBright = 0.55 + 0.45 *
			(sin(ang * 2.0 + time * 0.5) * 0.5 + 0.5);

		half3 ringCol = mix(purple, hotPurple, half(core));
		half ringI = half((core + halo * 0.45) * fade * angBright);
		acc += ringCol * ringI;
	}

	col += acc;

	// --- Сетка мерцающих точек ---
	float cell = 8.0;
	float2 cellId = floor(position / cell);
	float2 inCell = fract(position / cell) - 0.5;
	float toCenter = length(inCell);

	float dotR = 0.18;
	if (toCenter < dotR) {
		float seed = hash21(cellId);
		float freq = mix(0.6, 2.6, hash21(cellId + 7.0));
		float phase = seed * 6.2831;

		// Мерцание [0..1]
		float pulse = sin(time * freq + phase) * 0.5 + 0.5;

		// Часть точек гасим, чтобы выглядело хаотично
		if (seed < 0.35) {
			pulse = 0.0;
		}

		// Мягкий край точки
		float falloff = 1.0 - smoothstep(0.0, dotR, toCenter);

		half dotI = half(pulse * falloff * 0.45);
		col += half3(dotI * 0.75h, dotI * 0.65h, dotI);
	}

	return half4(col, 1.0h);
}
