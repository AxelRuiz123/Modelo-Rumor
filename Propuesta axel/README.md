# Modelo Rumor AC


## Descripcion
Observar el ciclo de vida de un rumor (nacimiento, expansión y declive) dentro de una población estática.

---

## Estados de las celdas
| Estado | Valor interno | Color |
|---|---|---|
| Ignorante | `0` | Verde |
| Chismoso | `1` | Rojo |
| No chismoso | `2` | Azul |

---
## Reglas del autómata

### Vecindario
Moore

### Tipo de reglaS
Semitotalista

### Transiciones de estado
| Estado actual | Condición | Estado siguiente | Probabilidad |
|---|---|---|---|
| Ignorante (0) | `n = 0` | Ignorante (0) | 1.0 |
| Ignorante (0) | `n > 0` | Chismoso (1) | `P(0→1) = 1 − (1−B)^n` |
| Ignorante (0) | `n > 0`, no se volvió chismoso | No chismoso (2) | `G` |
| Ignorante (0) | `n > 0`, no cambió | Ignorante (0) | `1 − P(0→1) − G·(1−P(0→1))` |
| Chismoso (1) | siempre | Chismoso (1) | 1.0|
| No chismoso (2) | siempre | No chismoso (2) | 1.0 |

### Parametros ajustables
| Parametro | Descripción | Valor por defecto | Rango |
|---|---|---|---|
| `B` | Probabilidad de convertirse en vecino chismoso | `0.30` | `[0.0, 1.0]` |
| `G` | Probabilidad de volverse en vecino no chismoso | `0.10` | `[0.0, 1.0]` |

---
## Controles
| Acción | Efecto |
|---|---|
| Clic | Marca la celda como el primer chismoso |
| `SPACE` | Pausa / reanuda la simulación |
| `R` | Reinnicia la simulaciónn |
