const {assert} = require("chai");

const Blender = artifacts.require("./BlenderEthDai.sol");

require("chai")
    .use(require("chai-as-promised"))
    .should();

contract("BlenderEthDai", (accounts) => {
    let blender;

    before(async () => {
        blender = await Blender.deployed();
    })

    describe("Deployment", async () => {
        it("Deploys Successfully", async () => {
            const address = await blender.address;

            assert.notEqual(address, 0x0);
            assert.notEqual(address, '');
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
        });

        it("Can add collateral", async () => {
            const collateralValue = web3.utils.toWei("1", "ether");

            await blender.add_collateral({from: accounts[1], value: collateralValue});

            const collateral = await blender.collateral(accounts[1]);

            assert.equal(collateral, collateralValue);
        })

        it("It can update price", async () => {
            await blender.update_price(3500);
            const price = await blender.asset_price();

            assert.equal(price, 3500);
        })

        it("Non-owner cannot update price", async() => {
            assert.isRejected(blender.update_price(3000, {from: accounts[1]}));
        })
    })
})