// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * Ejercicio 2
 *
 * Vamos a crear una serie de modifiers que nos ayudarán añadir validaciones
 * y protecciones a nuestros contratos.
 *
 * Escenarios a validar/proteger:
 * 1
 * - acceso: que solo el admin sea quien pueda ejecutar una función
 *   nombre modifer: soloAdmin
 *   aplicar al método: metodoAccesoProtegido
 *
 * 2
 * - permiso: que personas de una lista puedan llamar a un método
 *   nombre modifer: soloListaBlanca
 *   aplicar al método: metodoPermisoProtegido
 *   Adicional:
 *   - definir un setter para incluir addresses en la lista blanca protegido por soloAdmin
 *   - nombre del método: incluirEnListaBlanca
 *
 * 3
 * - tiempo: que un método sea llamado dentro de un rango de tiempo
 *   nombre modifer: soloEnTiempo
 *   aplicar al método: metodoTiempoProtegido
 *
 * 4
 * - pausa: que un método pueda ser pausado y reanudado
 *   nombre modifer: pausa
 *   aplicar al método: metodoPausaProtegido
 *   Adicional:
 *   - definir un método para cambiar ese booleano que tenga el modifier de soloAdmin
 *   - nombre del metodo: cambiarPausa
 *
 *
 * Notas:
 *  - para el modifier de tiempo, se puede usar block.timestamp
 *  - para el modifier de pausa, se puede usar un booleano
 *  - dejar los cuerpos de todos los métodos en blanco
 *
 * Testing: Ejecutar el siguiente comando:
 * - npx hardhat test test/EjercicioTesting_2.js
 */

contract Ejercicio_2 {

    address public admin = 0x08Fb288FcC281969A0BBE6773857F99360f2Ca06;
    mapping(address => bool) public listaBlanca;
    uint256 public tiempoLimite = block.timestamp + 30 days;
    bool public pausado = false;

    modifier soloAdmin() {
        require(msg.sender == admin, "No eres el admin");
        _;
    }

    modifier soloListaBlanca() {
        require(listaBlanca[msg.sender], "Fuera de la lista blanca");
        _;
    }

    modifier soloEnTiempo() {
        require(block.timestamp <= tiempoLimite, "Fuera de tiempo");
        _;
    }

    modifier pausa() {
        require(!pausado, "El metodo esta pausado");
        _;
    }

    function metodoAccesoProtegido() public soloAdmin {
        
    }

    function incluirEnListaBlanca(address usuario) public soloAdmin {
        listaBlanca[usuario] = true;
    }

    function metodoPermisoProtegido() public soloListaBlanca {
        
    }

    function metodoTiempoProtegido() public soloEnTiempo {
        
    }

    function cambiarPausa() public soloAdmin {
        pausado = true;
    }

    function metodoPausaProtegido() public pausa {
        
    }
}
