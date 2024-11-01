('use strict');
const { Sequelize } = require('/app/node_modules/sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'AGGREGATEDTRANSACTIONS', // Table name
      'NETMDRTOTAL', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
      }
    );

    await queryInterface.addColumn(
      'AGGREGATEDTRANSACTIONS', // Table name
      'NETACTUALTOTAL', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('AGGREGATEDTRANSACTIONS', 'NETMDRTOTAL');
    await queryInterface.removeColumn(
      'AGGREGATEDTRANSACTIONS',
      'NETACTUALTOTAL'
    );
  },
};
