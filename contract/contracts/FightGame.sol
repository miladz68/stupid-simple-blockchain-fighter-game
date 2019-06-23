pragma solidity 0.5.8;

contract FightGame {
    struct Fighter {
        uint128 strengh;
        uint64  win;
        uint64  loss;
        address owner;
    }

    Fighter[] fighters;
    mapping(uint256 => address) fighterToOwner;

    function spawnZombie() external{
        Fighter memory newFighter = Fighter(1,0,0,msg.sender);
        uint id = fighters.push(newFighter);
        fighterToOwner[id] = msg.sender;
    }

    modifier onlyOwner(uint256 _id){
        address owner = fighterToOwner[_id];
        require(owner == msg.sender, "attcker is not the owner of the fighter");
        _;
    }

    function attack(uint256 _zombieId, uint256 _attackedZ) external onlyOwner(_zombieId){
        // address owner = msg.sender;
        Fighter storage attacker = fighters[_zombieId];
        Fighter storage attacked = fighters[_attackedZ];
        // uint strDif = attacker.strengh - attacked.strengh;
        // require(!(strDif / 10 > attacker.strengh || - strDif / 10 > attacker.strengh),"attacker must be withing 10 percent of attackee");

        if (attacker.strengh + 2 > attacked.strengh) {
            attacker.win++;
            attacked.loss++;
            attacker.strengh += attacked.strengh/10;
        } else {
            attacked.win++;
            attacker.loss++;
            attacker.strengh -= attacked.strengh/5;
        }
    }

    function allFighters() public view returns(uint128[] memory,uint128[] memory,uint64[] memory,uint64[] memory) {
        uint128[] memory ids = new uint128[](fighters.length);
        uint128[] memory strgs = new uint128[](fighters.length);
        uint64[] memory wins = new uint64[](fighters.length);
        uint64[] memory losses = new uint64[](fighters.length);
        for (uint128 i = 0; i < fighters.length; i++) {
            ids[i] = i;
            strgs[i] = fighters[i].strengh;
            wins[i] = fighters[i].win;
            losses[i] = fighters[i].loss;
        }
        return (ids,strgs,wins,losses);
    }
    function getFighterById(uint _fighterId) public view returns(uint128, uint64, uint64, address) {
        Fighter memory fgh = fighters[_fighterId];
        return (fgh.strengh, fgh.win,fgh.loss,fgh.owner);
    }

    function myFighters() public view returns(uint[] memory,uint128[] memory,uint64[] memory,uint64[] memory) {
        uint[] memory ids = new uint[](fighters.length);
        uint128[] memory strgs = new uint128[](fighters.length);
        uint64[] memory wins = new uint64[](fighters.length);
        uint64[] memory losses = new uint64[](fighters.length);
        //Fighter memory attacker = fighters[_attackerId];
        for (uint i = 0; i < fighters.length; i++) {
            if (fighters[i].owner == msg.sender){
                ids[i] = i;
                strgs[i] = fighters[i].strengh;
                wins[i] = fighters[i].win;
                losses[i] = fighters[i].loss;
            }
        }
        return (ids,strgs,wins,losses);
    }
    function enemyFighters() public view returns(uint[] memory,uint128[] memory,uint64[] memory,uint64[] memory) {
        uint[] memory ids = new uint[](fighters.length);
        uint128[] memory strgs = new uint128[](fighters.length);
        uint64[] memory wins = new uint64[](fighters.length);
        uint64[] memory losses = new uint64[](fighters.length);
        //Fighter memory attacker = fighters[_attackerId];
        for (uint128 i = 0; i < fighters.length; i++) {
            if (fighters[i].owner != msg.sender){
                ids[i] = i;
                strgs[i] = fighters[i].strengh;
                wins[i] = fighters[i].win;
                losses[i] = fighters[i].loss;
            }
        }
        return (ids,strgs,wins,losses);
    }


    function attackableFighters(uint256 _attackerId) public view returns(uint128[] memory,uint64[] memory,uint64[] memory) {
        uint128[] memory strgs = new uint128[](fighters.length);
        uint64[] memory wins = new uint64[](fighters.length);
        uint64[] memory losses = new uint64[](fighters.length);
        //Fighter memory attacker = fighters[_attackerId];
        for (uint i = 0; i < fighters.length; i++) {
            if (true){
                strgs[i] = fighters[i].strengh;
                wins[i] = fighters[i].win;
                losses[i] = fighters[i].loss;
            }
        }
        return (strgs,wins,losses);
    }
}