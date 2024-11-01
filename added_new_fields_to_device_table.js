('use strict');
const { Sequelize } = require('sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'DEVICES', // Table name
      'APPVERSION', // New column name
      {
        type: Sequelize.STRING(200), // Data type (adjust if necessary)
      }
    );

    await queryInterface.addColumn(
      'DEVICES', // Table name
      'LIBVERSION', // New column name
      {
        type: Sequelize.STRING(200), // Data type (adjust if necessary)
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('DEVICES', 'APPVERSION');
    await queryInterface.removeColumn('DEVICES', 'LIBVERSION');
  },
};
