('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'TRANSACTIONS', // Table name
      'BANKID', // New column name
      {
        type: Sequelize.INTEGER, // Data type (adjust if necessary)
        references: {
          model: 'BANKS', // Referenced table
          key: 'ID', // Referenced column (primary key of AppCode)
        },
        onDelete: 'SET NULL', // Optional behavior on AppCode deletion
        onUpdate: 'CASCADE', // Optional behavior on AppCode update
      }
    );
  },
  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('TRANSACTIONS', 'BANKID');
  },
};
