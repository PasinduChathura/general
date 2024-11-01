('use strict');
const { Sequelize } = require('/app/node_modules/sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'MERCHANTS', // Table name
      'MDRPERCENTAGE', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('TRANSACTIONS', 'MDRPERCENTAGE');
  },
};
