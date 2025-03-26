('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'USERS', // Table name
      'USERTYPE', // New column name
      {
        type: Sequelize.STRING(50), // Data type (adjust if necessary)
      }
    );
    await queryInterface.addColumn(
      'USERS', // Table name
      'ALLOWEDPATHS', // New column name
      {
        type: Sequelize.TEXT, // Data type (adjust if necessary)
      }
    );
  },
  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('USERS', 'USERTYPE');
    await queryInterface.removeColumn('USERS', 'ALLOWEDPATHS');
  },
};
