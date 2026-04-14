// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaCongo
 * @dev Registro de tecnicas de coccion hermetica y procesamiento de hojas de mandioca.
 * Serie: Sabores de Africa (24/54)
 */
contract CulturaCongo {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 hermeticidadLiboke; // Escala de sellado (1-10)
        uint256 gradoTrituracion;   // Rotura de fibra del Saka-Saka (1-10)
        bool usaAceitePalma;        // Base lipidica de la emulsion
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Liboke de Pescado (Ingenieria termica)
        registrarPlato(
            "Liboke ya Mbisi", 
            "Pescado de rio, tomates, cebollas, especias, hojas de platano.",
            "Envolver los ingredientes en hojas de platano creando un sello hermetico y cocinar sobre brasas o vapor.",
            10, 
            0, 
            false
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _hermeticidad, 
        uint256 _trituracion,
        bool _palma
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_hermeticidad <= 10, "Escala de hermeticidad invalida");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            hermeticidadLiboke: _hermeticidad,
            gradoTrituracion: _trituracion,
            usaAceitePalma: _palma,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 hermeticidad,
        uint256 trituracion,
        bool palma,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.hermeticidadLiboke, p.gradoTrituracion, p.usaAceitePalma, p.likes);
    }
}
