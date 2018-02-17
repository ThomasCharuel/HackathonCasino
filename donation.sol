pragma solidity ^0.4.18;
pragma experimental ABIEncoderV2;
//"0xca35b7d915458ef540ade6068dfe2f44e8fa733c", "croix rouge"
//"0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "monoprix"
//"0xca35b7d915458ef540ade6068dfe2f44e8fa733c", ["machin", "lait"]
//0, 1, 3, 5

contract DonationContract {

  // Represents a supply donated
  struct Supply {
    
    uint supplyId; // The product identifier
    
    uint donationId; // The donation identifier

    uint amount; // The amount of this supply

    uint unitPrice; // The price per unit of this supply
  }

  // Represents a supply donation between a store and an association
  struct Donation {

    address association; // The association adress
    address store; // The store address

    bool confirmed; // The association has to confirm the donation
  }

  // Represents a store
  struct Store {
    string name;
  }

  // Stores an 'Store' struct for an address
  mapping (address => Store) public stores;
  address[] public storeAccts;

  // Represents an association
  struct Association {
    string name;
  }

  // Stores an 'Association' struct for an address
  mapping (address => Association) public associations;
  address[] public associationAccts;

  // Dynamically sized array of donations
  Donation[] public donations;
  
  // Dynamically sized array of supplies
  Supply[] public supplies;



  // Event to allow clients to react on a supply donation
  //event SendDonation(Donation donation);

  // Event to allow clients to react on donation confirmation by the association
  //event ConfirmDonation(Donation donation);


  function DonationContract() public {

  }

  // The donator calls this when giving supplies to an association
  function createDonate(address _receiver) public {
    
    // Create a new donation
    donations.push(Donation({
        association: _receiver, // The association adress
        store: msg.sender,
        confirmed: false
    }));
    
    
    // Fires the Sent event after the transaction is performed
    // SendDonation(donation);
  }
  
  function addSupplyToDonation(uint _donationId, uint _supplyId, uint _amount, uint _unitPrice) public {
      // require()
      
      // Create a new supply that is linked to a donation
      supplies.push(Supply({
          supplyId: _supplyId,
          amount: _amount,
          unitPrice: _unitPrice,
          donationId: _donationId
      }));
  }

  // Create an association account
  function createAssociation(address _address, string _name) public {
    //require();
    // Assign the association name
    associations[_address].name = _name;
    associationAccts.push(_address) -1;
  }

  // Create a store account
  function createStore(address _address, string _name) public {
    //require();
    // Assign the store name
    stores[_address].name = _name;
    storeAccts.push(_address) -1;
  }

  // Confirm a donation
  function confirmDonation(uint _donationId) public {
      donations[_donationId].confirmed = true;
  }
}