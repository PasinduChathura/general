('use strict');
const { Sequelize } = require('/app/node_modules/sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'TRANSACTIONS', // Table name
      'MDRRATE', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
      }
    );

    await queryInterface.addColumn(
      'TRANSACTIONS', // Table name
      'MDRAMOUNT', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
      }
    );

    await queryInterface.addColumn(
      'TRANSACTIONS', // Table name
      'ACTUALAMOUNT', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
        defaultValue: false, // Default value
        allowNull: false, // Ensuring it is not null
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('TRANSACTIONS', 'MDRRATE');
    await queryInterface.removeColumn('TRANSACTIONS', 'MDRAMOUNT');
    await queryInterface.removeColumn('TRANSACTIONS', 'ACTUALAMOUNT');
  },
};
