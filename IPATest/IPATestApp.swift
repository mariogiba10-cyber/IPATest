//  IPATestApp.swift
//  Punto de entrada: es lo primero que ejecuta iOS al abrir la app.

import SwiftUI

@main                                  // Marca esta estructura como "inicio" de la app
struct IPATestApp: App {
    var body: some Scene {
        WindowGroup {                  // La ventana principal de la app
            ContentView()              // Muestra nuestra pantalla
                .preferredColorScheme(.dark) // Barra de estado clara sobre fondo oscuro
        }
    }
}
