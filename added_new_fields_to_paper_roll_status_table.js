('use strict');
const { Sequelize } = require('/app/node_modules/sequelize');
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up({ context: queryInterface }) {
    await queryInterface.addColumn(
      'PAPER_ROLL_STATUS', // Table name
      'ISACTIONTAKEN', // New column name
      {
        type: Sequelize.BOOLEAN, // Data type (adjust if necessary)
        allowNull: false, // Prevent null values
        defaultValue: false, // Default value
      }
    );

    await queryInterface.addColumn(
      'PAPER_ROLL_STATUS', // Table name
      'COMMENT', // New column name
      {
        type: Sequelize.STRING(2000), // Data type (adjust if necessary)
      }
    );
  },

  async down({ context: queryInterface }) {
    await queryInterface.removeColumn('PAPER_ROLL_STATUS', 'ISACTIONTAKEN');
    await queryInterface.removeColumn('PAPER_ROLL_STATUS', 'COMMENT');
  },
};
