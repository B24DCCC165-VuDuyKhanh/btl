require('dotenv').config();
const app = require('./app');
const { sequelize } = require('./models');

const PORT = process.env.PORT || 4002;

async function start() {
  try {
    await sequelize.authenticate();
    console.log('MySQL connection established successfully.');
    await sequelize.authenticate();
    app.listen(PORT, '0.0.0.0', () => {
      console.log(`Backend server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error('Unable to start server:', error);
    process.exit(1);
  }
}

start();
