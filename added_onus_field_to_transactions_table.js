('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'TRANSACTIONS', // Table name
      'ONUS', // New column name
      {
        type: Sequelize.BOOLEAN, // Data type (adjust if necessary)
        allowNull: false, // Prevent null values
        defaultValue: false, // Default value
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('TRANSACTIONS', 'ONUS');
  },
};
