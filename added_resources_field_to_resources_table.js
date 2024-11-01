('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'RESOURCES', // Table name
      'ISENABLED', // New column name
      {
        type: Sequelize.BOOLEAN, // Data type (adjust if necessary)
        allowNull: false, // Prevent null values
        defaultValue: true, // Default value
      }
    );
    await queryInterface.addColumn(
      'RESOURCES', // Table name
      'ISTIMEBASED', // New column name
      {
        type: Sequelize.BOOLEAN, // Data type (adjust if necessary)
        allowNull: false, // Prevent null values
        defaultValue: false, // Default value
      }
    );
    await queryInterface.addColumn(
      'RESOURCES', // Table name
      'TODATE', // New column name
      {
        type: Sequelize.DATE, // Data type (adjust if necessary)
      }
    );
    await queryInterface.addColumn(
      'RESOURCES', // Table name
      'FROMDATE', // New column name
      {
        type: Sequelize.DATE, // Data type (adjust if necessary)
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('RESOURCES', 'ISENABLED');
    await queryInterface.removeColumn('RESOURCES', 'ISTIMEBASED');
    await queryInterface.removeColumn('RESOURCES', 'TODATE');
    await queryInterface.removeColumn('RESOURCES', 'FROMDATE');
  },
};
