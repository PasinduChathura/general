('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'DEVICES', // Table name
      'SESSIONID', // New column name
      {
        type: Sequelize.STRING(255), // Data type (adjust if necessary)
      }
    );
  },
  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('DEVICES', 'SESSIONID');
  },
};
