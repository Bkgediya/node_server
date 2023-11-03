const app = require("./app");
const supertest = require("supertest");
const request = supertest(app);

test('should return a response', async () => { 
    const response = await request.get("/test")
    expect(response.status).toBe(200)
    expect(response.text).toBe("Hello World")
 })
