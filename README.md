# Agenda Essencial

Agenda en línea de Essencial Estética Integral para Dani y Vale. Se actualiza en tiempo real.

- `index.html`: la app completa (un solo archivo).
- `schema.sql`: tablas y reglas de Supabase (proyecto `agenda-essencial`).
- `manifest.json` e íconos: permiten "Agregar a pantalla de inicio" en el teléfono.

## Uso
1. Abrir el link de GitHub Pages en el teléfono.
2. Ingresar una sola vez con el correo y la clave compartidos (la sesión queda guardada).
3. Elegir "Dani" o "Vale" (se recuerda en ese teléfono).
4. En el navegador: Compartir / menú → "Agregar a pantalla de inicio".

## Reglas
- Tipo de reserva: Evaluación o Tratamiento, con duración editable.
- Estados: Reservada, Confirmada, Pagada, Cancelada.
- Comisión de Dani: 10% del monto final, solo si la captó Dani, la clienta está marcada como nueva,
  la cita está Pagada y es la primera cita pagada de esa clienta.

## Migrar
Supabase permite transferir el proyecto a otra organización (Project Settings > General > Transfer project).
El repo se puede transferir en GitHub (Settings > Transfer ownership).
