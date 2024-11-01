('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'DEVICES', // Table name
      'LOCKSTATUS', // New column name
      {
        type: Sequelize.STRING(50), // Data type (adjust if necessary)
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('DEVICES', 'LOCKSTATUS');
  },
};
