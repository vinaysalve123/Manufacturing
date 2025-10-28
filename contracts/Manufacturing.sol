// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Manufacturing Project
 * @dev This smart contract tracks manufacturing orders, production, and delivery status.
 */

contract Manufacturing {
    struct Product {
        uint256 id;
        string name;
        string status; // Created, InProduction, or Delivered
        address owner;
    }

    mapping(uint256 => Product) public products;
    uint256 public nextProductId;
    address public admin;

    event ProductCreated(uint256 indexed id, string name, address indexed owner);
    event StatusUpdated(uint256 indexed id, string newStatus);

    constructor() {
        admin = msg.sender;
        nextProductId = 1;
    }

    /// @notice Creates a new product in the system
    function createProduct(string memory _name) public {
        products[nextProductId] = Product(nextProductId, _name, "Created", msg.sender);
        emit ProductCreated(nextProductId, _name, msg.sender);
        nextProductId++;
    }

    /// @notice Updates the production status of a product
    /// @dev Only admin can change the status
    function updateStatus(uint256 _id, string memory _newStatus) public {
        require(msg.sender == admin, "Only admin can update status");
        require(_id < nextProductId && _id > 0, "Invalid product ID");
        products[_id].status = _newStatus;
        emit StatusUpdated(_id, _newStatus);
    }

    /// @notice Returns details of a product by its ID
    function getProduct(uint256 _id) public view returns (Product memory) {
        require(_id < nextProductId && _id > 0, "Invalid product ID");
        return products[_id];
    }
}

