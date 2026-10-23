//  ContentView.swift
//  Pantalla principal: título, mensaje, contador y botón.

import SwiftUI
import UIKit   // Solo para la vibración al pulsar (UIImpactFeedbackGenerator)

struct ContentView: View {

    // @State es la "memoria" de la pantalla: cuando cambia, SwiftUI la redibuja sola.
    @State private var contador: Int = 0

    var body: some View {
        ZStack {
            // 1) Fondo degradado que ocupa toda la pantalla
            LinearGradient(
                colors: [Color.indigo, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // 2) Contenido apilado verticalmente
            VStack(spacing: 24) {
                Spacer()

                // Título
                Text("IPATest")
                    .font(.system(size: 46, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.white)

                // Mensaje de confirmación
                Text("¡Mi primera IPA funciona!")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(Color.white.opacity(0.85))

                // Tarjeta translúcida con el contador
                VStack(spacing: 6) {
                    Text("PULSACIONES")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.white.opacity(0.7))

                    Text("\(contador)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .monospacedDigit()                  // Cifras de ancho fijo (no "bailan")
                        .foregroundStyle(Color.white)
                        .contentTransition(.numericText())  // Animación al cambiar el número (iOS 16+)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
                .background(
                    Color.white.opacity(0.15),
                    in: RoundedRectangle(cornerRadius: 28, style: .continuous)
                )
                .padding(.horizontal, 32)
                .padding(.top, 16)

                Spacer()

                // Botón principal: llama a sumar() al pulsarlo
                Button(action: sumar) {
                    Label("Sumar 1", systemImage: "plus.circle.fill")
                }
                .buttonStyle(EstiloBotonPrincipal())
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                .accessibilityHint("Aumenta el contador en una unidad")
            }
        }
    }

    // Lógica del botón: suma 1 con animación y una vibración suave
    private func sumar() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
            contador += 1
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

// Estilo propio del botón: cápsula blanca que se encoge un poco al pulsarla
struct EstiloBotonPrincipal: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.weight(.bold))
            .foregroundStyle(Color.indigo)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(Color.white, in: Capsule())
            .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
