package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import javax.sql.DataSource;
import jakarta.annotation.PostConstruct;
import java.util.List;

@Repository
public class JdbcTradingCardRepository {

    @Autowired
    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;

    @PostConstruct
    private void initialize() {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<TradingCard> getAllTradingCards() {
        String sql = "SELECT * FROM tradingcards";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            TradingCard tradingCard = new TradingCard();
            tradingCard.setCardNo(rs.getLong("cardNo"));
            tradingCard.setType(rs.getString("type"));
            tradingCard.setName(rs.getString("name"));
            tradingCard.setValue(rs.getFloat("value"));
            return tradingCard;
        });

    }

    @SuppressWarnings("deprecation")
    public TradingCard getTradingCardByCardNo(long cardNo) {
        String sql = "SELECT * FROM tradingcards WHERE cardNo = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{cardNo}, (rs, rowNum) -> {
            TradingCard tradingCard = new TradingCard();
            tradingCard.setCardNo(rs.getLong("cardNo"));
            tradingCard.setType(rs.getString("type"));
            tradingCard.setName(rs.getString("name"));
            tradingCard.setValue(rs.getFloat("value"));
            return tradingCard;
        });
    }

    public void saveTradingCard(TradingCard tradingCard) {
        String sql = "INSERT INTO tradingcards (cardNo, name, type, value) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, tradingCard.getCardNo(), tradingCard.getName(), tradingCard.getType(), tradingCard.getValue());
    }

    public void updateTradingCard(TradingCard tradingCard) {
        String sql = "UPDATE tradingcards SET name = ?, type = ?, value = ? WHERE cardNo = ?";
        jdbcTemplate.update(sql, tradingCard.getName(), tradingCard.getType(), tradingCard.getValue(), tradingCard.getCardNo());
    }

    public void deleteTradingCardByCardNo(Long cardNo) {
        String sql = "DELETE FROM tradingcards WHERE cardNo = ?";
        jdbcTemplate.update(sql, cardNo);
    }
}












